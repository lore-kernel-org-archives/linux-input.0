From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?=
        <thomas_os@shipmail.org>
Subject: [PATCH 0/4] Add support for updated vmware hypercall instruction
Date: Sun, 18 Aug 2019 16:33:12 +0200
Message-ID: <20190818143316.4906-1-thomas_os@shipmail.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, pv-drivers@vmware.com
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>

VMware has started using "vmcall" / "vmmcall" instead of an inl instruction
for the "backdoor" interface. This series detects support for those
instructions.
Outside of the platform code we use the "ALTERNATIVES" self-patching
mechanism similarly to how this is done with KVM.
Unfortunately we need two x86 cpu feature flags for this, since we need
the default instruction to be "inl". IIRC the vmmouse driver is used by
other virtualization solutions than VMware, and those might break if
they encounter any of the other instructions.
