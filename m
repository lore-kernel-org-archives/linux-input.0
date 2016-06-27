From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [1/2] Revert "HID: multitouch: enable palm rejection if device
 implements confidence usage"
Date: Mon, 27 Jun 2016 17:13:44 -0500
Message-ID: <5771A518.4080104@dell.com>
References: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466670690-77458-1-git-send-email-allen_hung@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Allen Hung <allen_hung@dell.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Andy,

> (And I'm curious why 1.4.3 seems to have been pulled.  Might it have
> been this issue?  For better or for worse, I upgraded in the narrow
> window in which it was available on Dell's website.)

It wasn't pulled in relation to this issue.  It was something else. 
Nothing I'm aware of in the 1.4.3 BIOS changes should have made this any
worse than previously.  Maybe something else in the stack moved that
exaggerated the problem or you started palming the touchpad more?

Your Tested-by: is that meaning that it's fixed entirely for you?  Not
getting stuck at all now?

Thanks,
