From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 24/27] devicetree: fix a series of wrong
	file references
Date: Wed, 20 Jun 2018 08:42:23 +0800
Message-ID: <CAGb2v67s29mYa+hcYFWCokmzLwi7aYyeBwDnQiTJQYxT0GxPNA@mail.gmail.com>
References: <cover.1528990947.git.mchehab+samsung@kernel.org>
 <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <bce1b59268ac2d659fd7cb37f89285ef2acc8316.1528990947.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, linux-pci@vger.kernel.org, Binghui Wang <wangbinghui@hisilicon.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>, Xiaowei Song <songxiaowei@hisilicon.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Zhou Wang <wangzhou1@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 15, 2018 at 12:09 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files got renamed, their references broke.
>
> Manually fix a series of broken refs at the DT bindings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

Acked-by: Chen-Yu Tsai <wens@csie.org>
