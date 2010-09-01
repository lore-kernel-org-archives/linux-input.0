From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: Normalized reported profile number for pyra
 button events.
Date: Wed, 1 Sep 2010 12:43:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009011242570.26813@pobox.suse.cz>
References: <1283196536.2059.0.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283196536.2059.0.camel@neuromancer>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <stefan_achatz@web.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stefan Achatz <erazor_de@users.sourceforge.net>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Stephane Chatty <chatty@enac.fr>, Don Prince <dhprince-devel@yahoo.co.uk>, Dmitry Torokhov <dtor@mail.ru>, Kees Bakker <kees.bakker@xs4all.nl>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 30 Aug 2010, Stefan Achatz wrote:

> Pyra uses profile numbers in range 0-4 for everything except button
> events. Using range 1-5 consistent now.
> 
> Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
> ---
>  drivers/hid/hid-roccat-pyra.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat-pyra.c
> b/drivers/hid/hid-roccat-pyra.c
> index 6c09c15..9bf2304 100644
> --- a/drivers/hid/hid-roccat-pyra.c
> +++ b/drivers/hid/hid-roccat-pyra.c
> @@ -902,7 +902,11 @@ static void pyra_report_to_chrdev(struct
> pyra_device const *pyra,
>  		if (button_event->data2 == PYRA_MOUSE_EVENT_BUTTON_PRESS) {
>  			roccat_report.type = button_event->type;
>  			roccat_report.key = button_event->data1;
> -			roccat_report.value = pyra->actual_profile;
> +			/*
> +			 * pyra reports profile numbers with range 1-5.
> +			 * Keeping this behaviour.
> +			 */
> +			roccat_report.value = pyra->actual_profile + 1;
>  			roccat_report_event(pyra->chrdev_minor,
>  					(uint8_t const *)&roccat_report,
>  					sizeof(struct pyra_roccat_report));

Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
