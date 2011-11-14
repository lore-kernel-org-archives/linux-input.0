From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia
 W500
Date: Mon, 14 Nov 2011 11:08:10 -0800
Message-ID: <4EC1671A.3020107@gmail.com>
References: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40967 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab1KNTIP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 14:08:15 -0500
Received: by gyc15 with SMTP id 15so5212207gyc.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 11:08:14 -0800 (PST)
In-Reply-To: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, chris@cnpbagwell.com

On 11/14/2011 08:41 AM, Marek Vasut wrote:
> This patch adds USB ID for the touchpanel in Acer Iconia W500. The panel
> supports up to five fingers, therefore the need for a new addition of panel
> types.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Cc: chris@cnpbagwell.com

For patches that are simply device ID additions, please remember to add:

Cc: stable@vger.kernel.org

This really helps all distributors quickly pick up the additions.

Thanks!

-- Chase
