From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/3] TSC-40: fix checkstyle issues
Date: Tue, 13 Sep 2011 10:47:20 +0200
Message-ID: <20110913084720.GB27776@linutronix.de>
References: <CAH9NwWfEAag2+d_s3tbNyLV_oi23fTaeXtWvCm8-W+E69fxDcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:36321 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551Ab1IMIra (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 04:47:30 -0400
Content-Disposition: inline
In-Reply-To: <CAH9NwWfEAag2+d_s3tbNyLV_oi23fTaeXtWvCm8-W+E69fxDcA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

* Christian Gmeiner | 2011-09-13 10:18:35 [+0200]:

>Subject: [PATCH 2/3] TSC40: fix checkstyle issues
>
>This patch fixes all found problems.

Besides the checkpatch fixes you also increased the msleep delay. For
the checkpatch part it is probably better in include it in the previous
patch unless Dmitry prefers something different. The same goes probably
for the msleep part but pleae denote why this was required.

Sebastian
