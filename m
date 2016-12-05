From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] input: usbhid: fix improper check
Date: Mon, 05 Dec 2016 10:07:43 +0100
Message-ID: <1480928863.2206.1.camel@suse.com>
References: <1480828209-4131-1-git-send-email-bianpan201603@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480828209-4131-1-git-send-email-bianpan201603@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan201603@163.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Pan Bian <bianpan2016@163.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 2016-12-04 at 13:10 +0800, Pan Bian wrote:
> From: Pan Bian <bianpan2016@163.com>
> 
> Function hid_post_reset() returns 0 on success, or 1 on failures.

It seems like hid_post_reset() is buggy in not returning
a proper error code in the failure case. So your diagnosis
is right, but the fix is at the wrong place.

	Regards
		Oliver
