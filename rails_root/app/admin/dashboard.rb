ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_support" do
      span :class => "blank_slate" do
        span 'Need Support? Email us at:'
        span mail_to 'support@kickinespresso.zendesk.com'
      end
    end


    columns do
      column do
        panel "Recent User Logins" do
          table_for User.recent(5) do
            column("Email") {|user| link_to(user.email, admin_user_path(user))}
            column("Signed In at") {|user| user.last_sign_in_at.strftime("%A, %d %b %Y %l:%M %p")    }
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end
  end # content
end