From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v17 00/12] input: cyapa: instruction of cyapa patches
Date: Wed, 31 Dec 2014 08:11:20 -0800
Message-ID: <20141231161120.GA1385@newt.localdomain>
References: <1419988621-2919-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46705 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbaLaQLY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Dec 2014 11:11:24 -0500
Content-Disposition: inline
In-Reply-To: <1419988621-2919-1-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, bleung@google.com, dso@cypress.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dudley,

On Wed, Dec 31, 2014 at 09:16:49AM +0800, Dudley Du wrote:
> V17 patches have below updates, details of other updates see history =
list:
> 1) Fix kernel oops when system booting up with finger on TP.
> 2) Remove unnecessary error log that may to system.
> 3) Slipt out pm sleep code into cyapa_prepare_wakeup_controls(),
>    remove #indefs in function body of CONFIG_PM_SLEEP and CONFIG_PM_R=
UNTIME.
> 4) Supply stubs to cyapa_gen3_ops and cyapa_gen5_ops data structure t=
o avoid
>    checking for presence of various methods in ops.
> 6) Fix the meanings of some comments and return error code not clear =
issue.
[...]

It has build errors :(

  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CHK     kernel/config_data.h
  CC [M]  drivers/input/mouse/cyapa.o
In file included from include/linux/device.h:25:0,
                 from include/linux/i2c.h:30,
                 from drivers/input/mouse/cyapa.c:18:
drivers/input/mouse/cyapa.c:1339:21: error: =E2=80=98cyapa_runtime_susp=
end=E2=80=99 undeclared here (not in a function)
  SET_RUNTIME_PM_OPS(cyapa_runtime_suspend, cyapa_runtime_resume, NULL)
                     ^
include/linux/pm.h:347:21: note: in definition of macro =E2=80=98SET_RU=
NTIME_PM_OPS=E2=80=99
  .runtime_suspend =3D suspend_fn, \
                     ^
drivers/input/mouse/cyapa.c:1339:44: error: =E2=80=98cyapa_runtime_resu=
me=E2=80=99 undeclared here (not in a function)
  SET_RUNTIME_PM_OPS(cyapa_runtime_suspend, cyapa_runtime_resume, NULL)
                                            ^
include/linux/pm.h:348:20: note: in definition of macro =E2=80=98SET_RU=
NTIME_PM_OPS=E2=80=99
  .runtime_resume =3D resume_fn, \
                    ^
scripts/Makefile.build:257: recipe for target 'drivers/input/mouse/cyap=
a.o' failed
make[3]: *** [drivers/input/mouse/cyapa.o] Error 1
scripts/Makefile.build:402: recipe for target 'drivers/input/mouse' fai=
led
make[2]: *** [drivers/input/mouse] Error 2
scripts/Makefile.build:402: recipe for target 'drivers/input' failed
make[1]: *** [drivers/input] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:955: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....

--=20
- Jeremiah Mahler
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
