From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] input: stmpe-keyboard: Use devm_*() routines
Date: Fri, 9 Nov 2012 22:33:56 +0530
Message-ID: <CAKohponMrv5W2vgvN6+kqj0ZuXxCc38=-3zDzYDAh3mhvh9R_g@mail.gmail.com>
References: <3d6f34ca5960203a5efb761f4d56b4e10ee24827.1352474824.git.viresh.kumar@linaro.org>
	<20121109164503.GA17752@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121109164503.GA17752@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com
List-Id: linux-input@vger.kernel.org

On 9 November 2012 22:15, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> If input device was alocated with devm_* interface it does not need be
> explicitly unregistered/freed.

Thanks for pointing out:

Fixup:

commit 4bf57c85f49f16a139af80f8de76fa01eee77a5d
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Nov 9 22:31:34 2012 +0530

    fixup! input: stmpe-keyboard: Use devm_*() routines
---
 drivers/input/keyboard/stmpe-keypad.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c
b/drivers/input/keyboard/stmpe-keypad.c
index 6e25497..706b16f 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -326,16 +326,12 @@ static int __devinit stmpe_keypad_probe(struct
platform_device *pdev)
                        IRQF_ONESHOT, "stmpe-keypad", keypad);
        if (ret) {
                dev_err(&pdev->dev, "unable to get irq: %d\n", ret);
-               goto out_unregisterinput;
+               return ret;
        }

        platform_set_drvdata(pdev, keypad);

        return 0;
-
-out_unregisterinput:
-       input_unregister_device(input);
-       return ret;
 }

 static int __devexit stmpe_keypad_remove(struct platform_device *pdev)
@@ -344,7 +340,6 @@ static int __devexit stmpe_keypad_remove(struct
platform_device *pdev)
        struct stmpe *stmpe = keypad->stmpe;

        stmpe_disable(stmpe, STMPE_BLOCK_KEYPAD);
-       input_unregister_device(keypad->input);

        return 0;
 }
