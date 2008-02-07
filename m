From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Unicode events?
Date: Thu, 7 Feb 2008 22:42:06 +0000
Message-ID: <20080207224206.GB4404@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:19518 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755435AbYBGWpF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2008 17:45:05 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080207224354.WOGN3337.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <linux-input@vger.kernel.org>; Thu, 7 Feb 2008 22:43:54 +0000
Received: from implementation.famille.thibault.fr ([82.21.96.230])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080207224322.VMQO17393.aamtaout02-winn.ispmail.ntl.com@implementation.famille.thibault.fr>
          for <linux-input@vger.kernel.org>; Thu, 7 Feb 2008 22:43:22 +0000
Received: from samy by implementation.famille.thibault.fr with local (Exim 4.68)
	(envelope-from <samuel.thibault@labri.fr>)
	id 1JNFRW-0001Ps-BV
	for linux-input@vger.kernel.org; Thu, 07 Feb 2008 23:42:06 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

Some braille devices may be used as input devices, and some of them
don't have a PC-like keyboard, but a braille keyboard: when pressing dot
1, 'a' should be output.  Currently, there is no way to do this with the
input layer: if we generate KEY_A, then that will be right for qwerty
keyboards, but not for non-qwerty keyboards.  Then I'm wondering:
shouldn't we add a unicode event type, which will just hold the unicode
character that should happen?

Samuel
