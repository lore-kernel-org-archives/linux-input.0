From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: [PATCH 0/2] tsc2007: remove HR timer, make platform callbacks optional
Date: Tue, 23 Jun 2009 13:54:40 +0200
Message-ID: <4A40C280.2010801@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756443AbZFWLyu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kwangwoo.lee@gmail.com, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

This patch removes the HR timer, since it's bad to do synchronous I2C
in the HR timer callback context. The new implementation makes use
of the global workqueue. The work is scheduled every 5ms when polling
rather than 5 us.

Secondly the platform callbacks are only called if supplied. Makes
the driver to fallback on only pressure calculation to decide when
the pen is up. This is not as accurate as having a function to call,
but that's not possible on all hardware configurations.

--Richard
