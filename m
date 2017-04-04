From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/4] input: misc: introduce Atmel PTC driver
Date: Tue, 4 Apr 2017 08:47:16 +0200
Message-ID: <20170404064716.6uibtyin73otpqsd@rfolt0960.corp.atmel.com>
References: <20170331152250.12758-1-ludovic.desroches@microchip.com>
 <20170331152250.12758-2-ludovic.desroches@microchip.com>
 <20170403155840.vln4wg56iunrmdcw@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170403155840.vln4wg56iunrmdcw@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Apr 03, 2017 at 05:58:40PM +0200, Alexandre Belloni wrote:
> On 31/03/2017 at 17:22:47 +0200, Ludovic Desroches wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> I think you probably want to switch to your microchip email.
> 
> Also, this requires a proper commit message.

I'll fix this, I'll take the cover letter as commit message and update
the mail address.

> 
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > +struct atmel_ptc {
> > +	void __iomem		*ppp_regs;
> > +	void __iomem		*firmware;
> > +	int			irq;
> > +	uint8_t			imr;
> > +	volatile struct atmel_qtm_mailbox __iomem	*qtm_mb;
> > +	struct clk		*clk_per;
> > +	struct clk		*clk_int_osc;
> > +	struct clk		*clk_slow;
> > +	struct device		*dev;
> > +	struct completion	ppp_ack;
> > +	unsigned int		button_keycode[ATMEL_PTC_MAX_NODES];
> > +	struct input_dev	*buttons_input;
> > +	struct input_dev	*scroller_input[ATMEL_PTC_MAX_SCROLLERS];
> > +	bool			buttons_registered;
> > +	bool			scroller_registered[ATMEL_PTC_MAX_SCROLLERS];
> > +	uint32_t		button_event[ATMEL_PTC_MAX_NODES/32];
> > +	uint32_t		button_state[ATMEL_PTC_MAX_NODES/32];
> > +	uint32_t		scroller_event;
> > +	uint32_t		scroller_state;
> 
> You should use u8, u16 and u32 instead of uint8_t, uint16_t and
> uint32_t.

Do you want me to also change the atmel_ptc.h header and use __u8 and co?
Since I share it with bare metal software, uintxx_t was more convenient.

> 
> > diff --git a/include/uapi/linux/atmel_ptc.h b/include/uapi/linux/atmel_ptc.h
> > new file mode 100644
> > index 0000000..d15c4df
> > --- /dev/null
> > +++ b/include/uapi/linux/atmel_ptc.h
> 
> 
> Is there any sample application showing how to configure the PTC?
> 

Tooling and examples are in development.

The tool allows you to produce the atmel_ptc.conf binary or to tweak the
configuration in real time with commands such as:
- set node_group_conf count 10
- get node_config 0
- dump_conf
- export_conf atmel_ptc.conf

The application only use input devices.


Ludovic
