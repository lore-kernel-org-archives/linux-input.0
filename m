From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 0/2] qt1070 & gpio_keys add pinctrl consumer
Date: Tue, 23 Oct 2012 15:16:27 +0200
Message-ID: <20121023131627.GE18964@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

	The following patch series add the pinctrl support to the follwing
	keybords:

	 - gpio_keys
	 - qt1070

	The pinctrl is optionnal as not everyone need it

	If no objection I'll apply them via at91 as I have a long patch series
	of pinctrl for at91

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (2):
      input: qt1070: add pinctrl consumer
      input: gpio_keys: add pinctrl consumer

 drivers/input/keyboard/gpio_keys.c |   11 +++++++++++
 drivers/input/keyboard/qt1070.c    |   11 +++++++++++
 2 files changed, 22 insertions(+)

Best Regards,
J.
