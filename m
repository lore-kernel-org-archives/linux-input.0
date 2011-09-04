From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] arm: exynos4: fix incorrect pad configuration for
	keypad row lines
Date: Sun, 4 Sep 2011 10:53:01 +0100
Message-ID: <20110904105301.01b82323@lxorguk.ukuu.org.uk>
References: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315129244-26489-1-git-send-email-thomas.abraham@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> SMDKV310 board does not have pull-up resistors populated for the keypad
> row lines (unlike the smdk boards for the previous Samsung SoC's). So
> the pad pull-up for all keypad row lines should be enabled for
> smdkv310 board.

So does this change the behaviour of existing boards, and if so isn't it
the SMDKV310 that hould be providing the alternate gpio configuration
function ?
