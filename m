From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: hid-related 5.2-rc1 boot hang
Date: Tue, 28 May 2019 11:11:20 -0700
Message-ID: <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
 <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 5/28/19 10:45 AM, Benjamin Tissoires wrote:
> On Tue, May 28, 2019 at 7:15 PM Jiri Kosina <jikos@kernel.org> wrote:
>> Just to confirm -- I guess reverting 4ceabaf79 and a025a18fe would work
>> this around, right?

Yes, reverting that pair on top of 5.2-rc1 works around the issue.

> It would be also interesting to know which distribution and which
> systemd version you are running (if you are on systemd).

$ systemd --version
systemd 229
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD -IDN

on "Ubuntu 16.04.6"
