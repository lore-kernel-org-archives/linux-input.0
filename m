From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 6/6] hid-multitouch: class MT_CLS_STANTUM is redundant
 with MT_CLS_CONFIDENCE
Date: Fri, 20 May 2011 10:35:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105201031560.28291@pobox.suse.cz>
References: <1305807498-8785-1-git-send-email-benjamin.tissoires@enac.fr> <1305807498-8785-7-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1305807498-8785-7-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 19 May 2011, Benjamin Tissoires wrote:

> Stantum devices used to work with MT_CLS_STANTUM but MT_CLS_CONFIDENCE
> is exactly the same. This patch switches them to this generic class,
> and remove the unused MT_CLS_STANTUM.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
>  drivers/hid/hid-multitouch.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index feeb0b7..65b92d2 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -88,7 +88,6 @@ struct mt_class {
>  #define MT_CLS_DUAL_INRANGE_CONTACTNUMBER	3
>  #define MT_CLS_CYPRESS				4
>  #define MT_CLS_EGALAX				5
> -#define MT_CLS_STANTUM				6
>  #define MT_CLS_3M				7
>  #define MT_CLS_CONFIDENCE			8
>  #define MT_CLS_CONFIDENCE_MINUS_ONE		9

Benjamin,

is it intentional that you are leaving the hole in the numbering here?

I don't think there would be any issue with re-numbering 7-10, would it?

-- 
Jiri Kosina
SUSE Labs
