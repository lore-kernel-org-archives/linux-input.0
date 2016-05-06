From: "jeffrey.lin" <yajohn@gmail.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch driver
Date: Fri,  6 May 2016 16:24:14 +0800
Message-ID: <1462523054-435-1-git-send-email-jeffrey.lin@rad-ic.com>
References: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461923113-426-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, grant.likely@linaro.org, robh+dt@kernel.org, jeesw@melfas.com, bleung@chromium.org
Cc: jeffrey.lin@rad-ic.com, roger.yang@rad-ic.com, KP.li@rad-ic.com, albert.shieh@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry:

About question "In my previous e-mail I requested you to enumerate chan=
ges that are made to the driver, compared to the previous version(s). T=
here were also a few questions that I did not get answer for."

In order to improve flash read/write security of boot loader. We increa=
se handshake flow and command sequence complexity. Our previous flash w=
rite functions are single side action. New version we increase more han=
dshake flow to check data accuracy. Firmware update flow increases as b=
elow:

    1.Check firmware file size, if file size is null, return fail.
    2.Check touch MCU run on main firmware or boot loader. Both cases h=
ave different return values. In case of flash write function, if touch =
MCU work on main code, touch driver need issue enter boot loader comman=
d to touch MCU and wait for MCU boot mode ready.
    3.Turn off touch MCU watchdog function to prevent interference.
    4.Check boot loader write state path ready.
    5.Send boot mode trigger command to unlock flash-write-protection.
    6.Execute page write command. Each write command will wait touch MC=
U acknowledge and then execute next step.
    7.Leave boot loader to check firmware work.
    8.Raydium touch driver check touch MCU work on main firmware or not=
=2E If touch MCU work on main firmware and return correct acknowledge t=
o kernel, this means flash write command success.
    9.Write checksum information to flash.

Every touch driver flash write command accompany write command, acknowl=
edge byte and wait for acknowledge command. Different sequences have di=
fferent write commands and different state to return ack.

Previous version as below :

    1.Get firmware data
    2.Force jump to boot loader by soft reset command
    3.Wait for boot loader acknowledge
    4.Flash page write data directly
    5.Force jump to main firmware if page write data finish.

=20
New flow increase more acknowledges for each I2C command to make sure b=
oot loader got the message and finish the actions. After finish flash w=
rite data, new flow will le touch MCU jump to main firmware and check m=
ain code work well. Then write the total checksum to flash and check th=
e consistence of flash code in every boot time.
=20
New flash write flow is very different form previous version, but more =
safe. The difference is big. Sorry make you confuse.

The question "I still can't figure out the logic in read/write mesage h=
andling. Here we see that device is supposedly reporting data_bank_addr=
 as LE integer, but query_bank_info is returned in native CPU endiannes=
s. With fastboot command we assume that we are dealing with BE-encoded =
data and convert it to CPU-endianness before using it.
=20
However in raydium_i2c_read_message() we convert from CPU endianness to=
 BE and this comfuses me (does the device really return data in one end=
ianness but accepts in another endianness?"

Raydium MCU support direct access mode by I2C bus to access register or=
 physical buffer directly. In this direct access mode, our touch MCU us=
e BE integer by using commands of raydium_i2c_read_message/ raydium_i2c=
_send_message. Otherwise, raydum I2C normal mode use LE integer. By the=
 way, the command buffer of soft_rst_cmd[] is upside down.

The question "By the way, why do you have raydium_i2c_read_message() ha=
ndle reads above MAX_PKG_SIZE? There are no callers that want it."

Generally, I2C bus has maximum packet size but total touch report point=
s maybe exceed this size. Unfortunately my experimental chromebook devi=
ce exceed this size. So that I=E2=80=99ll split this read command two o=
r more to make sure all data are read.
