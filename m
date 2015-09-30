From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: hid-input: allow input_configured callback return
 errors
Date: Wed, 30 Sep 2015 10:09:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1509301008550.30132@pobox.suse.cz>
References: <20150925231451.GA40951@dtor-ws> <20150929225259.GA33426@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44537 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753974AbbI3IJq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Sep 2015 04:09:46 -0400
In-Reply-To: <20150929225259.GA33426@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Jaikumar Ganesh <jaikumarg@android.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, James C Boyd <jcboyd.dev@gmail.com>, Karl Relton <karllinuxtest.relton@ntlworld.com>, David Herrmann <dh.herrmann@gmail.com>, Olivier Gay <ogay@logitech.com>, Ross Skaliotis <rskaliotis@gmail.com>, Jamie Lentin <jm@lentin.co.uk>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Andreas Fleig <andreasfleig@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>, Peter Wu <peter@lekensteyn.nl>, Goffredo Baroncelli <kreijack@inwind.it>, Mathieu Magnaudet <mathieu.magnaudet@gmail.com>, Brent Adam <brentadamdev@gmail.com>, Yang Bo <linuxsea@163.com>, Seth Forshee <seth.forshee@canonical.com>, Andrew Duggan <aduggan@synaptics.com>, Dan Carpenter <dan.carpenter@oracle.com>Frank Praznik <fr>

On Tue, 29 Sep 2015, Dmitry Torokhov wrote:

> When configuring input device via input_configured callback we may
> encounter errors (for example input_mt_init_slots() may fail). Instead
> of continuing with half-initialized input device let's allow driver
> indicate failures.

Applied to hid.git#for-4.4/upstream, thanks Dmitry.

-- 
Jiri Kosina
SUSE Labs

