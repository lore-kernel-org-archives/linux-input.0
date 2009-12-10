From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH 0/7] msi-wmi driver and cleanups
Date: Thu, 10 Dec 2009 19:07:18 +0100
Message-ID: <20091210190718.6bb3caea@destiny.ordissimo>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
	<200912101618.28865.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200912101618.28865.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On Thu, 10 Dec 2009 16:18:27 +0100, Thomas Renninger <trenn@suse.de> wrote :

> Hi Anisse,
> 
> thanks for these!
> A quick comment on each:
>  
> > Anisse Astier (6):
> >   msi-wmi: remove useless includes
>     -> good catch, I probably C&P it from another acpi file.
> >   msi-wmi: rework init
>     -> might look a bit nicer now, thanks.
> >   msi-wmi: remove custom runtime debug implementation
>     -> fine.
> >   msi-wmi: remove unused field 'instance' in key_entry structure
>     -> nice cleanup
> >   msi-wmi: replace one-condition switch-case with if statement
>     -> might be nicer
> >   msi-wmi: switch to using input sparse keymap library
>     -> I didn't go into detail, but this looks like a very nice
>     cleanup and code reduction.
> 

Thanks for taking the time to check this out.

Anisse
