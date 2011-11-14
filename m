From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/7] A few patches to cyttsp
Date: Mon, 14 Nov 2011 00:15:40 -0800
Message-ID: <20111114080939.10141.46174.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34009 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1KNIPp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 03:15:45 -0500
Received: by iage36 with SMTP id e36so6951500iag.19
        for <linux-input@vger.kernel.org>; Mon, 14 Nov 2011 00:15:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org

Hi Javier,

I am sending a few patches that I made while trying to understand the
Cypress TTSP driver. I am still not quite happy with the SPI read method
and I am also wondering if cyttsp_power_on could be made less messy.

Current open/close methods seem to be not very useful: even though we
stop interrupts we do not put the chip into low power mode. Is there a
way to do so?

Regarding PM methods - why do we have conditional 'use sleep' and what
exactly wakeup() method is supposed to do? Why is it a platform method?

Thanks.

-- 
Dmitry
