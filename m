From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] Input: add support for Semtech SX8654 I2C
 touchscreen controller
Date: Sat, 07 Mar 2015 13:32:25 +0100
Message-ID: <1425731545.2281.3.camel@tiscali.nl>
References: <1425666099-8365-1-git-send-email-sebastien.szymanski@armadeus.com>
	 <20150306182155.GB4540@dtor-ws> <20150307005717.GD26151@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150307005717.GD26151@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?ISO-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov schreef op vr 06-03-2015 om 16:57 [-0800]:
> Applied with some cosmetic edits and DT bindings folded into this patch.

Was one of these cosmetic edits perhaps an edit to use
    MODULE_LICENSE("GPL v2");

in sx8654.c? That would make that macro match the license stated in the
comment at the top of that file.

Thanks,


Paul Bolle
