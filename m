From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v6 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Date: Fri, 30 Nov 2018 08:51:28 +0000
Message-ID: <5C00FA0F.3020303@st.com>
References: <1543337529-22301-1-git-send-email-p.paillet@st.com>
 <1543337529-22301-4-git-send-email-p.paillet@st.com>
 <20181128094801.GF6828@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128094801.GF6828@sirena.org.uk>
Content-Language: en-US
Content-ID: <9DB619103FCF3F4681616A2DF44F3FBE@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org

Le 11/28/2018 10:48 AM, Mark Brown a écrit :
> On Tue, Nov 27, 2018 at 04:52:15PM +0000, Pascal PAILLET-LME wrote:
>> The STPMIC1 regulators supply power to the application processor as well as
>> to the external system peripherals such as DDR, Flash memories and system
>> devices.
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Sorry Mark, I will submit my changes on the regulator driver in separate 
patches.

pascal
