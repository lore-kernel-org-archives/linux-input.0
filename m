From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [2.6.36 regression] Under linux console gpm cursor now going to
 opposite direction of mouse
Date: Fri, 20 Aug 2010 22:33:16 +0200
Message-ID: <20100820223316.4f6ac734@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:53402 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0HTUeM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 16:34:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Somewhere between 2.6.35 and Linus's tree as of this writing gpm
started moving its cursor to the opposite direction of mouse movement.

e.g. moving mouse up causes cursor to move down, moving mouse left
     causes cursor to go right

Under 2.6.35 the cursor moved into the same direction as the mouse.

Note, mouse is synaptics touchpad (Acer TravelMate660):
  Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps: 0x904713/0x4006/0x0


When I get around to it I will try to get more precise information as
to when this regression got introduced, eventually bisecting.

Bruno
