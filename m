From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] input: use input_mutex instead of BKL when opening input device
Date: Tue, 9 Mar 2010 21:06:35 +0100
Message-ID: <201003092106.35740.arnd@arndb.de>
References: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com> <1268162386-2745-2-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab0CIUGh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 15:06:37 -0500
In-Reply-To: <1268162386-2745-2-git-send-email-cascardo@holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur <jkacur@gmail.com>

On Tuesday 09 March 2010, Thadeu Lima de Souza Cascardo wrote:
> There are three types of input character devices: mousedev, joydev and
> evdev. They all use the same major device and, then, their opening is
> multiplexed in input_open_file.
> 
> After the BKL pushdown, this multiplexing is protected by the BKL. But
> there's already a mutex used for adding and removing to the table
> indexed by input_open_file.
> 
> So, we use this mutex instead of the BKL. Since it will call the
> handlers' open function under the mutex, I've checked that the current
> functions do not call input_{un,}register_{handler,device}, which are
> the only other functions to take the mutex.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
