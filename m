From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: Re: [PATCH] input: touchscreen: imx6ul_tsc: Use 'dev' instead of
 dereferencing it repeatedly
Date: Wed, 2 Oct 2019 07:32:42 +0200
Message-ID: <c0773e65-fc14-8cad-06a3-861bd264a44c@ysoft.com>
References: <1569315731-2387-1-git-send-email-Anson.Huang@nxp.com>
 <20190930230806.GX237523@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190930230806.GX237523@dtor-ws>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anson Huang <Anson.Huang@nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, swboyd@chromium.org, Linux-imx@nxp.com, kernel@pengutronix.de, linux-input@vger.kernel.org, festevam@gmail.com, mojha@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 01. 10. 19 1:08, Dmitry Torokhov wrote:
> On Tue, Sep 24, 2019 at 05:02:11PM +0800, Anson Huang wrote:
>> Add helper variable dev = &pdev->dev to simply the code.
> 
> Do we get any code savings from this?

I noticed Anson submitted similar patches into various other subsystems.
Here [1] is a very detailed response from David Laight shedding some light
on this topic.

[1] https://lkml.org/lkml/2019/9/24/151

>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>>   drivers/input/touchscreen/imx6ul_tsc.c | 37 +++++++++++++++++-----------------
>>   1 file changed, 19 insertions(+), 18 deletions(-)
