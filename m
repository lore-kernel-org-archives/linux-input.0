From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] input: touchscreen: edt-ft5x06: don't make device
 a wakeup source by default
Date: Tue, 22 May 2018 12:54:13 -0500
Message-ID: <20180522175413.GA24850@rob-hp-laptop>
References: <20180517090552.5704-1-daniel@zonque.org>
 <20180517090552.5704-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180517090552.5704-2-daniel@zonque.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, May 17, 2018 at 11:05:50AM +0200, Daniel Mack wrote:
> Allow configuring the device as wakeup source through device properties, as
> not all platforms want to wake up on touch screen activity.
> 
> The I2C core automatically reads the "wakeup-source" DT property to
> configure a device's wakeup capability, and board supports files can set
> I2C_CLIENT_WAKE in the flags.

This will break wake-up on working systems. Looks like mostly i.MX, but 
there's one AM437x board. If that board doesn't care, then it is up to 
Shawn.

Rob
