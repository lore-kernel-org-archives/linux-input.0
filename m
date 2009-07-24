From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 0/2] tsc2007: controlled removal and reduced number of I2C
 transactions
Date: Fri, 24 Jul 2009 18:12:07 +0200
Message-ID: <4A69DD57.6030405@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753345AbZGXQMU@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>
List-Id: linux-input@vger.kernel.org

Two patches are supplied, booth are supposed to be applied against my 
previous ones, which are added to the -mm-tree.

The first one is proposed by Dmitry Torokhov, I have just made some 
changes so it applied to my previous changes, and I tried it out.

The second one decreases the number of I2C transactions transferred by 
the driver. A unnecessary one during probe and an unnecessary power down 
during each poll for coordinates are removed. The chip is explicitly 
powered down before waiting for interrupts.

--Richard
