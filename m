From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] ideapad: let Fn+F5 also trigger KEY_BLUETOOTH
Date: Tue, 14 Jun 2011 10:08:20 +0100
Message-ID: <1308042502.3450.3.camel@i7.infradead.org>
References: <1308040109-12038-1-git-send-email-ike.pan@canonical.com>
	 <4DF71C01.6080504@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4DF71C01.6080504@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ike Panhc <ike.pan@canonical.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Matthew Garrett <mjg@redhat.com>, Dmitry Torohov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 2011-06-14 at 16:29 +0800, Ike Panhc wrote:
> I think it is better to solve this in driver not in user space application 
> because on some other platforms, the KEY_WLAN and KEY_BLUETOOTH are separate.

I think it's better to do it in userspace. It's not as if it's hard to
define another KEY_ and just tell the truth about what happened. Let
userspace work out what to do with it.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation
