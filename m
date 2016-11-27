From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] input: touchscreen: sample averaging for imx6ul_tsc
Date: Sun, 27 Nov 2016 10:39:10 -0200
Message-ID: <CAOMZO5CCtLdH9_5vGXfqg1rAizngVc_EWaoE+JfcfTrMmJT4xA@mail.gmail.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Sun, Nov 27, 2016 at 5:44 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
>
> This patch adds sample averaging support to the imx6ul_tsc device
> driver.
>
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
