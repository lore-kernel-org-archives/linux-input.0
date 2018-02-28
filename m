From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [RFC 2/4] mfd: add Gateworks System Controller core driver
Date: Wed, 28 Feb 2018 13:16:02 -0800
Message-ID: <CAJ+vNU2aeFAKf6e7RashG50Gu5qb3mqGvJUEPprh4AjFGs+MLg@mail.gmail.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com> <20180228185302.GD1203@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228185302.GD1203@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 28, 2018 at 10:53 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> +             dev_err(&client->dev, ">> 0x%02x %d\n", reg, ret);
>> +             return ret;
>> +     }
>> +     dev_dbg(&client->dev, ">> 0x%02x=0x%02x (%d)\n", reg, val, retry);
>> +
>> +        return 0;
>
> Hi Tim
>
> There appears to be a few spaces vs tabs issues in this file.
>
>       Andrew
>

Thanks. I'll run through checkpatch prior to v2.

Tim
