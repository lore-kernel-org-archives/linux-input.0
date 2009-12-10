From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/7] msi-wmi driver and cleanups
Date: Thu, 10 Dec 2009 16:18:27 +0100
Message-ID: <200912101618.28865.trenn@suse.de>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46273 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760901AbZLJPSY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 10:18:24 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>

Hi Anisse,

thanks for these!
A quick comment on each:
 
> Anisse Astier (6):
>   msi-wmi: remove useless includes
    -> good catch, I probably C&P it from another acpi file.
>   msi-wmi: rework init
    -> might look a bit nicer now, thanks.
>   msi-wmi: remove custom runtime debug implementation
    -> fine.
>   msi-wmi: remove unused field 'instance' in key_entry structure
    -> nice cleanup
>   msi-wmi: replace one-condition switch-case with if statement
    -> might be nicer
>   msi-wmi: switch to using input sparse keymap library
    -> I didn't go into detail, but this looks like a very nice
    cleanup and code reduction.

Thanks,

   Thomas
> 
> Thomas Renninger (1):
>   X86 drivers: Introduce msi-wmi driver
> 
>  drivers/platform/x86/Kconfig   |   11 ++
>  drivers/platform/x86/Makefile  |    1 +
>  drivers/platform/x86/msi-wmi.c |  286 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 298 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/platform/x86/msi-wmi.c
> 
> 


