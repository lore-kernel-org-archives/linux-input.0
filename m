From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] i2c-hid: Fix "incomplete report" noise
Date: Mon, 9 Jul 2018 14:29:07 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1807091428570.997@cbobk.fhfr.pm>
References: <20180622162549.9563-1-jandryuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180622162549.9563-1-jandryuk@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Jason Andryuk <jandryuk@gmail.com>
Cc: linux-kernel@vger.kernel.org, john-s-84@gmx.net, stable@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Jun 2018, Jason Andryuk wrote:

> Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage")
> started writing messages when the ret_size is <= 2 from i2c_master_recv.
> However, my device i2c-DLL07D1 returns 2 for a short period of time
> (~0.5s) after I stop moving the pointing stick or touchpad.  It varies,
> but you get ~50 messages each time which spams the log hard.
> [  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)
> 
> This has also been observed with a i2c-ALP0017.
> [ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)
> 
> Only print the message when ret_size is totally invalid and less than 2
> to cut down on the log spam.
> 
> Reported-by: John Smith <john-s-84@gmx.net>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
