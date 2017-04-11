From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v2 2/2] xen,input: repair xen-kbdfront resolution setting
 via xenstore
Date: Tue, 11 Apr 2017 11:14:00 +0200
Message-ID: <e4157b94-3647-cc87-4c72-76442fefa921@suse.com>
References: <20170411085028.6750-1-jgross@suse.com>
 <20170411085028.6750-3-jgross@suse.com>
 <7ce36d3c-5921-53fa-12fb-3940dc5023de@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ce36d3c-5921-53fa-12fb-3940dc5023de@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 11/04/17 11:00, Oleksandr Andrushchenko wrote:
> Hi, Juergen,
> 
> could you please make one more patch in the series:
> 
> the code that you fix in this patch is ok, but most
> 
> of the functionality of the xenkbd_set_connected
> 
> is still useless: feature-abs-pointer/request-abs-pointer
> 
> negotiation has only meaning at probe time, when we are
> 
> configuring input device:
> 
>     if (abs) {
>         __set_bit(EV_ABS, ptr->evbit);
>         input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
>         input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
>     } else {
>         input_set_capability(ptr, EV_REL, REL_X);
>         input_set_capability(ptr, EV_REL, REL_Y);
>     }
> Once the input device is configured and registered (probe done)
> 
> we do not touch/re-configure that input device anymore,
> 
> regardless of the setting negotiation at xenkbd_set_connected
> 
> time. Thus, this code is not needed and can be cleaned out.
> 
> What your patch actually fixes is the fact that
> 
> "xenbus_switch_state(dev, XenbusStateConnected);" was not called,
> 
> so this is the only line needed.

This makes sense.

I'll modify patch2 according to your suggestion instead of adding
another patch removing most of the stuff added by patch 2.


Juergen
