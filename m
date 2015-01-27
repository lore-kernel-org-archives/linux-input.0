From: Daniel Martin <daniel.martin@secunet.com>
Subject: [v2] synaptics: match PNP-Id is not sufficient for min/max quirks
Date: Tue, 27 Jan 2015 09:34:00 +0100
Message-ID: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:52750 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbA0I2b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:28:31 -0500
In-Reply-To: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com

Hi,

this is the second version of my patches to address the problems
described at:
    https://bugzilla.kernel.org/show_bug.cgi?id=91541

I have incorporated changes according to Hans comments. That means I
removed the patch
    Input: synaptics - Add PnP id for X1 Carbon 1nd
as the PnP id doesn't belong into the list topbuttonpad_pnp_ids and in
the first patch
    Input: synaptics - Split synaptics_resolution(), query ...
I removed the SYN_ID_MAJOR() major check.

Is there anything else I should change?


Cheers,
    Daniel

