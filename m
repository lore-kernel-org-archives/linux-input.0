From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Tue, 8 Oct 2019 14:44:03 +0300
Message-ID: <20191008114403.GB4015@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
 <20191008113511.GA4015@jack.zhora.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191008113511.GA4015@jack.zhora.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi@etezian.org>
Cc: Stephan Gerhold <stephan@gerhold.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > -	if (!i2c_check_functionality(client->adapter,
> > -				I2C_FUNC_PROTOCOL_MANGLING)) {
> > +	type = (enum mms_type)device_get_match_data(&client->dev);
> 
> you don't need any cast here.

sorry, please ignore :)

Andi
