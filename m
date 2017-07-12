From: Mauro Salvini <mauro.salvini@smigroup.net>
Subject: Re: [PATCH] dt-bindings: input: tsc2005: fix vio-supply property
Date: Wed, 12 Jul 2017 14:08:34 +0200
Message-ID: <1499861314.2301.4.camel@smigroup.net>
References: <20170712080111.7094-1-mauro.salvini@smigroup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from MAIL.SMIGROUP.IT ([82.188.252.231]:59124 "EHLO mail.smigroup.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756630AbdGLMJS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 08:09:18 -0400
In-Reply-To: <20170712080111.7094-1-mauro.salvini@smigroup.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org

On Wed, 2017-07-12 at 10:01 +0200, Mauro Salvini wrote:
> tsc2005 documentation reports that vio-supply property is
> optional, but
> actually this property is required (driver fails with error if not
> present)

Hi,
completely forget my previous patch: I missed some commits (especially
f7bf6f58675a76c08e6e) and I wrongly deduced from driver probe fail that
vio-supply property must be required.

Sorry for the noise.

Mauro
