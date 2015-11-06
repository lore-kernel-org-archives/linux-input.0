From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: hid-logitech: Simplify wheel detection scheme
Date: Fri, 6 Nov 2015 21:18:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511062118140.23146@pobox.suse.cz>
References: <1446476212-2289-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446476212-2289-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2 Nov 2015, Simon Wood wrote:

> Simplfy how hid-logitech driver detects the native mode of the wheel,
> done by looking at the USB-ID revision and comparing bit mask.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

I've applied both patches to for-4.4/logitech. Thanks,

-- 
Jiri Kosina
SUSE Labs
