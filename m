From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: autoloading of modules failes
Date: Mon, 11 Aug 2014 14:42:12 +0200
Message-ID: <CAH9NwWe=o9=0iXTgASSdrQ=uN0SytN+g7bmJBMei2Y+NnST7mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57494 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbaHKMme (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Aug 2014 08:42:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org

Hi all.

I finally want to mainline the ar1021 input driver but the only bit
which is missing is autoloading via device-tree.

I have sent an RFC [0] some long time ago for the driver and it looked okay.

Maybe someone has time to help me to get automatic loading working so
that I can send the final patch. My current state can be found here:
[1]

[0] http://www.spinics.net/lists/linux-input/msg29419.html
[1] http://dpaste.com/0V0XTR5

thanks
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
