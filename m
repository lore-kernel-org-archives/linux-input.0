From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH] hid: assorted usage updates from hut 1.12
Date: Tue, 19 Apr 2011 15:13:03 -0400
Message-ID: <4DADDEBF.3050407@redhat.com>
References: <20100907154941.GA15742@redhat.com> <1303234544-5474-1-git-send-email-jarod@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab1DSTM6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 15:12:58 -0400
In-Reply-To: <1303234544-5474-1-git-send-email-jarod@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Jarod Wilson wrote:
> I've got a Tivo Slide bluetooth remote/dongle, which uses a fair number
> of hid usages that aren't currently mapped in hid-input.c. I'd initially
> written additions to hid-input.c with just this device in mind,
> including some bits that were specific to the device. This go around,
> I'm looking at adding/correcting as many generic HID usages from the HID
> Usage Tables, version 1.12, as I can -- which also serves to enable all
> but four of the buttons on the Tivo Slide remote[*].
>
> Outside of fixing the obviously incorrect mapping of 0xc 0x45 from
> KEY_RADIO to KEY_RIGHT, and making use of the new KEY_IMAGES (just added
> in 2.6.39-rc4) for AL Image Browser instead of KEY_MEDIA, these are
> purely additions, and thus should have no negative impact on any already
> functional HID devices. Most of the added mappings seemed to be
> perfectly logical to me, but there were a few that were mapped on more
> of an "I think this makes the most sense" basis.
>
> [*] I'll handle the last four tivo buttons via an hid-tivo.c follow-up.
>
> CC: Dmitry Torokhov<dmitry.torokhov@gmail.com>
> CC: Jiri Kosina<jkosina@suse.cz>
> Signed-off-by: Jarod Wilson<jarod@redhat.com>
> ---
> Nb: This is being submitted for 2.6.40, but I'd certainly have no
> objections to it going into 2.6.39. :)
>
>   drivers/hid/hid-input.c |   60 ++++++++++++++++++++++++++++++++++++++++------
>   1 files changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7f552bf..84d50e7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
...
> @@ -540,6 +578,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>   		case 0x18e: map_key_clear(KEY_CALENDAR);	break;
>   		case 0x191: map_key_clear(KEY_FINANCE);		break;
>   		case 0x192: map_key_clear(KEY_CALC);		break;
> +		case 0x192: map_key_clear(KEY_PLAYER);		break;

Sigh. I thought I'd re-tested after my last round of additions, but 
obviously not, since this will fail to build, because KEY_PLAYER should 
be case 0x193, rather than a duplicate... Will resubmit once I'm 100% 
positive things actually build and function. :\



-- 
Jarod Wilson
jarod@redhat.com


