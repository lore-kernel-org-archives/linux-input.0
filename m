From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 2/2] HID: wiimote: Parse calibration data of balance boards
Date: Mon, 17 Sep 2012 17:21:04 +0200
Message-ID: <50573FE0.6000003@butterbrot.org>
References: <1347877896-23939-1-git-send-email-dh.herrmann@googlemail.com> <1347877896-23939-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:36082 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab2IQPVG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:21:06 -0400
In-Reply-To: <1347877896-23939-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Darn, I just realized there may be an error here:

On 17.09.2012 12:31, David Herrmann wrote:
>   drivers/hid/hid-wiimote-ext.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
>
> +	/* apply calibration data */
> +	for (i = 0; i < 4; i++) {
> +		if (val[i] < ext->calib[i][1]) {
> +			tmp = val[i] - ext->calib[i][0];
> +			tmp *= 1700;
> +			tmp /= ext->calib[i][1] - ext->calib[i][0];
> +		} else {
> +			tmp = val[i] - ext->calib[i][1];
> +			tmp *= 1700;
> +			tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
I think this is not exactly the same formula as in my original patch; 
I'm quite sure this should read:

	tmp /= ext->calib[i][2] - ext->calib[i][1];
	tmp += 1700;

instead.

Florian
-- 
SENT FROM MY PDP-11
