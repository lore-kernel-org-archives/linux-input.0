From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [Patch-V3 0/6] HID: Support for the Logitech G920 Wheel
Date: Fri, 20 Nov 2015 10:32:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511201030330.20111@pobox.suse.cz>
References: <1447976535-2281-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447976535-2281-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 19 Nov 2015, Simon Wood wrote:

> Patch-V3 tweaked as per Benjamin's and Dmitry's requests.
> 
> This series of patches provide input support for the Logitech G920 gaming wheel.

This is now in hid.git#for-4.5/logitech.

Dmitry -- I've put the first patch into 
	hid.git#for-dmitry/logitech-g920-merge-base 

which is based on v4.3, and I then branched further for-4.5/logitech from 
it in my tree.

So if you pull for-dmitry/logitech-g920-merge-base branch from my tree, 
we're both fine and there would be no hassle no matter who merges with 
Linus first.

Do you want me to send you a "proper" pull request? :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
