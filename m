From: Eduard Hasenleithner <eduard@hasenleithner.at>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED support
Date: Mon, 28 Mar 2011 10:54:36 +0200
Message-ID: <4D904CCC.60307@hasenleithner.at>
References: <1301225280-5642-1-git-send-email-eduard@hasenleithner.at> <20110328083058.GA7368@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ftw.at ([213.235.244.131]:21790 "EHLO mail.ftw.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753014Ab1C1JKQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Mar 2011 05:10:16 -0400
In-Reply-To: <20110328083058.GA7368@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

On 2011-03-28 10:30, Henrik Rydberg wrote:
> Did you consider using the LED input interface? Implement the
> input_dev event hook and write EV_LED events to the device node.

Yes, but IMHO the OLED matrix displays for each button (8 buttons, 64x32 
pixels) are incompatible with the event interface LED IOCTLs. 
Furthermore, using the special wacom IOCTLs it is possible to set the 
luminance levels, which the event interface provides neither.

Please correct me if I'm wrong.

Br,
Eduard
