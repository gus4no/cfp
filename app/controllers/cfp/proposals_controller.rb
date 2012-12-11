require_dependency "cfp/application_controller"

module Cfp
  class ProposalsController < Controller
    before_filter :load_proposal, :only => [:edit, :update, :destroy]

    def index
      @proposals = Proposal.scoped_for(current_user)
    end

    def new
      @proposal = Proposal.new
    end

    def create
      @proposal = Proposal.new proposal_params[:proposal]
      @proposal.user = current_user
      if cfp_open? && @proposal.save
        redirect_to :proposals, :notice => t('proposals.created.success')
      else
        render :action => :new
      end
    end

    def edit
    end

    def update
      if @proposal.can_be_edited_by?(current_user) && @proposal.update_attributes(proposal_params[:proposal])
        redirect_to :proposals, :notice => t('proposals.edited.success')
      else
        render :action => "edit"
      end
    end

    def destroy
      @proposal.destroy if @proposal.can_be_edited_by?(current_user)
      redirect_to :proposals, :notice => t('proposals.deleted.success')
    end

    private
    def load_proposal
      @proposal = Proposal.find(params[:id])
    end

    def proposal_params
      params
    end
  end
end
