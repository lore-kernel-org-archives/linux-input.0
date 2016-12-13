From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: imx6ul_tsc - generalize the averaging property
Date: Tue, 13 Dec 2016 11:14:49 -0800
Message-ID: <1CDAF0C6-25E1-4CE9-8F98-F07333827B98@gmail.com>
References: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
 <20161213191050.3yrmxaubpgjh65bz@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161213191050.3yrmxaubpgjh65bz@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: fabio.estevam@freescale.com, mark.rutland@arm.com, devicetree@vger.kernel.org, haibo.chen@freescale.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On December 13, 2016 11:10:50 AM PST, Rob Herring <robh@kernel.org> wrote:
>On Sun, Dec 11, 2016 at 09:06:43AM +0200, Guy Shapiro wrote:
>> Make the avarage-samples property a general touchscreen property
>> rather than imx6ul device specific.
>> 
>> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
>> ---
>>  .../bindings/input/touchscreen/imx6ul_tsc.txt      | 11 ++----
>>  .../bindings/input/touchscreen/touchscreen.txt     |  3 ++
>>  drivers/input/touchscreen/imx6ul_tsc.c             | 46
>++++++++++++++++------
>>  3 files changed, 41 insertions(+), 19 deletions(-)
>
>You can't just switch existing bindings as that breaks compatibility 
>with old dtbs. The kernel driver would need to support both. Just 
>introduce the new common property and use it for your device.
>

The old binding is only in my tree at the moment, so I do not think there is compatibility concerns.

Are you OK with the new binding itself?


Thanks.

-- 
Dmitry
