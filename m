From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: usbhid: hid-core: fix recursive deadlock
Date: Thu, 19 Nov 2015 22:34:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1511192224490.20111@pobox.suse.cz>
References: <1447874755-8673-1-git-send-email-adi@adirat.com> <alpine.LNX.2.00.1511182137020.20111@pobox.suse.cz> <20151118230544.5c6f0c26@adipc> <20151118235856.GA30351@jcartwri.amer.corp.natinst.com> <20151119084743.08d11238@adipc>
 <alpine.LNX.2.00.1511191005240.20111@pobox.suse.cz> <20151119183325.265f02af@adipc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119183325.265f02af@adipc>
Sender: linux-kernel-owner@vger.kernel.org
To: Ioan-Adrian Ratiu <adi@adirat.com>
Cc: Josh Cartwright <joshc@ni.com>, pinglinux@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 19 Nov 2015, Ioan-Adrian Ratiu wrote:

> But please understand further my reasoning for submitting this patch. 
> Consider if this is a bug in the wacom driver or in the usbhid core? IMO 
> this is a usbhid bug: the critical region in hid_ctrl() is too big, 
> there is no reason for the call to hid_input_report() to be protected by 
> usbhid->lock.

Hmm, it's actually true that we might not need usbhid->lock during 
hid_input_report() at the end of the day, as we shouldn't be doing any 
URB-related operations there, neither iofl are being manipulated.

If you have already done the full analysis that shows that usbhid->lock is 
indeed not needed, this absolutely needs to go into changelog as proper 
justification.

Could you please reformulate the changelog in this respect and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs
