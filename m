From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/8] Input: hp-wmi - switch to using sparse keymap
	library
Date: Thu, 3 Dec 2009 02:03:38 -0800
Message-ID: <20091203100338.GA32433@core.coreip.homeip.net>
References: <20091202091056.30409.50455.stgit@localhost.localdomain> <20091202092425.30409.85617.stgit@localhost.localdomain> <20091203105811.06571039@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091203105811.06571039@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 03, 2009 at 10:58:11AM +0100, Anisse Astier wrote:
> Hi Dmitry,
> 
> On Wed, 02 Dec 2009 01:24:25 -0800, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote :
> 
> > diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> > index c284217..8868610 100644
> > --- a/drivers/platform/x86/hp-wmi.c
> > +++ b/drivers/platform/x86/hp-wmi.c
> > @@ -411,14 +342,29 @@ static int __init hp_wmi_input_setup(void)
> >  			    hp_wmi_tablet_state());
> >  	input_sync(hp_wmi_input_dev);
> >  
> > -	err = input_register_device(hp_wmi_input_dev);
> > +	err = wmi_install_notify_handler(HPWMI_EVENT_GUID, hp_wmi_notify, NULL);
> > +	if (err)
> > +		goto err_free_keymap;
> >  
> > -	if (err) {
> > -		input_free_device(hp_wmi_input_dev);
> > -		return err;
> > -	}
> > +	err = input_register_device(hp_wmi_input_dev);
> > +	if (err)
> > +		goto err_uninstall_notifier;
> >  
> >  	return 0;
> > +
> > + err_uninstall_notifier:
> > +	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
> > + err_free_keymap:
> > +	(hp_wmi_input_dev);
> > + err_free_dev:
> > +	input_free_device(hp_wmi_input_dev);
> > +	return err;
> > +}
> > +
> > +static void __exit hp_wmi_input_destroy(void)
> > +{
> > +	wmi_remove_notify_handler(HPWMI_EVENT_GUID);
> > +	input_unregister_device(hp_wmi_input_dev);
> >  }
> I'm not sure if you're calling sparse_keymap_free on the exit path.
> 

Guilty as charged ;)

-- 
Dmitry
