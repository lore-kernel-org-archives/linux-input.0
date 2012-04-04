From: simon.budig@kernelconcepts.de
Subject: [PATCH v5] Touchscreen driver for FT5x06 based EDT displays
Date: Wed,  4 Apr 2012 20:27:58 +0200
Message-ID: <1333564079-23893-1-git-send-email-simon.budig@kernelconcepts.de>
References: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:40710 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab2DDS2E (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 14:28:04 -0400
In-Reply-To: <1331050527-4902-1-git-send-email-simon.budig@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, agust@denx.de, yanok@emcraft.com

Hi all.

Here is a new iteration of the EDT polytouch driver. Compared to v4 it
incorporates the feedback from Anatolij Gustschin and some fixes from L=
othar
Wa=C3=9Fmann (bug on module unloading and obsolete power management api=
 use).

Please give feedback on problems or on further plans for inclusion into
mainline.

Thanks,
        Simon

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
