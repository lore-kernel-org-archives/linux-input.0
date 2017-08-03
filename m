From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: multitouch: Support Asus T304UA media keys
Date: Thu, 3 Aug 2017 11:24:34 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708031122530.30597@cbobk.fhfr.pm>
References: <20170724212225.3426-1-jprvita@endlessm.com> <20170724212225.3426-3-jprvita@endlessm.com> <alpine.LSU.2.20.1708021126550.30597@cbobk.fhfr.pm> <20170802121607.GA13659@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170802121607.GA13659@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux@endlessm.com, =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2 Aug 2017, Benjamin Tissoires wrote:

> Sorry for the delay. I was at GUADEC the whole past week and couldn't 
> get much kernel work done. I was thinking a little bit about this series 
> though. Patch 1 is fine, but patch 2 is a little bit more of an issue. 
> Ideally, I'd like to keep hid-multitouch from having too many vendor 
> specific code, but it looks like this is the easier way to handle things 
> here.
> 
> I guess the proper way of solving this situation would be to merge the
> generic windows 8 code from hid-multitouch into hid-input so that other
> drivers can benefit from it, but this is going to be a lot of work and
> -ETIME.

Yes, I actually have this on the list of things I'd eventually like to 
look into one day ... but we shouldn't let this block any further 
development.

I have applied the series now to for-4.14/multitouch (fixing up the 
0xff310076 -> HID_VD_ASUS_CUSTOM_MEDIA_KEYS constant in the condition as a 
followup).

Thanks,

-- 
Jiri Kosina
SUSE Labs
