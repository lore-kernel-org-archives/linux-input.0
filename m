From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC 11/12] HID: wiimote: Cache wiimote led state
Date: Wed, 15 Jun 2011 08:40:03 +0200
Message-ID: <201106150840.03119.oliver@neukum.org>
References: <1308095157-4699-1-git-send-email-dh.herrmann@googlemail.com> <1308095157-4699-12-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:60376 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1FOGmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jun 2011 02:42:19 -0400
In-Reply-To: <1308095157-4699-12-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, padovan@profusion.mobi

Am Mittwoch, 15. Juni 2011, 01:45:56 schrieb David Herrmann:
> @@ -319,7 +340,12 @@ static int wiimote_hid_probe(struct hid_device *hdev,
>  
>         atomic_set(&wdata->ready, 1);
>         hid_info(hdev, "New device registered\n");
> +
> +       /* by default set led1 after device initialization */
> +       spin_lock(&wdata->state.lock);

spin_lock_irq() or you might deadlock.

>         wiiproto_req_leds(wdata, WIIPROTO_FLAG_LED1);
> +       spin_unlock(&wdata->state.lock);
> +
>         return 0;

	Regards
		Oliver
