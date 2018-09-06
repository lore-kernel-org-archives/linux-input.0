From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] input: egalax_ts: add system wakeup support
Date: Thu, 6 Sep 2018 13:46:32 -0300
Message-ID: <CAOMZO5DzYBz3U=RT-HzzK5KMMnYipceCWh9eYuYRmBctkRZ_=w@mail.gmail.com>
References: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 6, 2018 at 12:24 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> This patch adds wakeup function support for egalax touch
> screen, if "wakeup-source" is added to device tree's egalax
> touch screen node, the wakeup function will be enabled, and
> egalax touch screen will be able to wakeup system from suspend.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
