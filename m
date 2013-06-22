From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH V3 3/5] arm: pxa: use matrix_keymap for all boards
Date: Sat, 22 Jun 2013 08:26:54 -0700
Message-ID: <51C5C23E.8070408@newsguy.com>
References: <1371527778-5236-1-git-send-email-chao.xie@marvell.com>
 <1371527778-5236-4-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371527778-5236-4-git-send-email-chao.xie@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chao Xie <chao.xie@marvell.com>
Cc: stefan@openezx.org, xiechao.mail@gmail.com, eric.y.miao@gmail.com, arnd@arndb.de, slapin@ossfans.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, haojian.zhuang@gmail.com, marek.vasut@gmail.com, laforge@openezx.org, linux-input@vger.kernel.org, sleep_walker@suse.cz, robert.jarzmik@free.fr, drwyrm@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On 06/17/2013 08:56 PM, Chao Xie wrote:
> Compile passed for configurations
> 
> em_x270_defconfig
>   em_x270x.c(MACH_EM_X270, MACH_EXEDA)
> 
> ezx_defconfig
>   ezx.c(MACH_EZX_A780, MACH_EZX_E680, MACH_EZX_A1200,
>         MACH_EZX_A910, MACH_EZX_E6, MACH_EZX_E2)
> 
> palmz72_defconfig
>   palmld.c(MACH_PALMLD), palmtreo.c(PALM_TREO),
>   palmtx.c(MACH_PALMTX), palmz72.c(MACH_PALMZ72),
>   palmt5.c(MACH_PALMT5)
> 
> pxa3xx_defconfig
>   littleton.c(MACH_LITTLETON), tarvorevb.c(MACH_TAVOREVB),
>   zylonite.c(MACH_ZYLONITE320), mioa701.c(MACH_MIOA701),
>   z2.c(MACH_ZIPIT2)
> 
> mainstone_defconfig
>   maintone.c(MACH_MAINSTONE)
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>


Tested-by: Mike Dunn <mikedunn@newsguy.com>

On a palm treo 680
