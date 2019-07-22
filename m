From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] HID: core: only warn once of oversize hid report
Date: Mon, 22 Jul 2019 10:23:00 -0700
Message-ID: <f7b1a46569a7208eb2be3b5cc3432b0aa97fc3ee.camel@perches.com>
References: <20190722163642.10417-1-stillcompiling@gmail.com>
         <20190722163642.10417-2-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722163642.10417-2-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stillcompiling@gmail.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2019-07-22 at 10:36 -0600, stillcompiling@gmail.com wrote:
> On HP spectre x360 convertible the message:
> hid-sensor-hub 001F:8087:0AC2.0002: hid_field_extract() called with n (192) > 32! (kworker/1:2)
> is continually printed many times per second, crowding out all other kernel logs
> Protect dmesg by printing the warning only one time.
[]
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
[]
> @@ -1311,7 +1311,7 @@ u32 hid_field_extract(const struct hid_device *hid, u8 *report,
>  			unsigned offset, unsigned n)
>  {
>  	if (n > 32) {
> -		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
> +		hid_warn_once(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
>  			 n, current->comm);
>  		n = 32;
>  	}

Is this papering over an actual defect somewhere else?
Trivially, this could use "%s: ...", __func__, ...
