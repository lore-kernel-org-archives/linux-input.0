From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] input: remove BKL from serio_raw
Date: Tue, 9 Mar 2010 21:06:50 +0100
Message-ID: <201003092106.51075.arnd@arndb.de>
References: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com> <1268162386-2745-2-git-send-email-cascardo@holoscopio.com> <1268162386-2745-3-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab0CIUGx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 15:06:53 -0500
In-Reply-To: <1268162386-2745-3-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur <jkacur@gmail.com>

On Tuesday 09 March 2010, Thadeu Lima de Souza Cascardo wrote:
> serio_raw open function already uses a mutex.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
