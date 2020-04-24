Return-Path: <SRS0=Nr1y=6I=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF47EC54FD0
	for <linux-input@archiver.kernel.org>; Fri, 24 Apr 2020 11:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E9A20728
	for <linux-input@archiver.kernel.org>; Fri, 24 Apr 2020 11:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgDXL5x (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:57:53 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:43077 "EHLO
        14.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXL5x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Apr 2020 07:57:53 -0400
X-Greylist: delayed 8399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2020 07:57:52 EDT
Received: from player797.ha.ovh.net (unknown [10.108.42.170])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 59E1124BDFF
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2020 11:29:46 +0200 (CEST)
Received: from etezian.org (213-243-141-64.bb.dnainternet.fi [213.243.141.64])
        (Authenticated sender: andi@etezian.org)
        by player797.ha.ovh.net (Postfix) with ESMTPSA id 37B20DAAF37C;
        Fri, 24 Apr 2020 09:29:39 +0000 (UTC)
Date:   Fri, 24 Apr 2020 12:29:37 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: mms114 - add extra compatible for mms345l
Message-ID: <20200424092937.GB460760@jack.zhora.eu>
References: <20200423102431.2715-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423102431.2715-1-stephan@gerhold.net>
X-Ovh-Tracer-Id: 12793037691999273709
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrhedugddugecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucfkpheptddrtddrtddrtddpvddufedrvdegfedrudeguddrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeljedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi guys,

>  	}, {
>  		.compatible = "melfas,mms152",
>  		.data = (void *)TYPE_MMS152,
> +	}, {
> +		.compatible = "melfas,mms345l",
> +		.data = (void *)TYPE_MMS345L,
>  	},

it's been some times I haven't been doing this, but is the order
of the patches correct? shouldn't the binding be updated first?

Andi
