Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55C939CD13
	for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931367; cv=none; b=iliJUbqY6vUFy7z6NLPAz9Jo33Tj5TXAvo46Bcz8QBoj4jl4ZHj+pD67NaVioWl036uF59phQignwtGLPnSHxGYDwipHMWSCJiWYLl6tBEoIxfbjm2dorMFjB+sIIDFwsqiqi0VnWdcoSF2uSukmlbhHJOPFC4RFSC+DZrPb4Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931367; c=relaxed/simple;
	bh=gHsgWFVqrv0P9maKI0X+B0ysshBoc37BVY0oULirNW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQtZ3kyvcFGjkm85ZTaPwDzincYR4casK7mQckeHaQ3WqljJPVoxQtIDZBfdoSgJ24IZ0Qu4TVWlYH9y9c0Iwmzjs/ldu2UMq4OURrQMicseMA8OwqvkirK6CRue23n+oGyhIxbnbLJ7Vdi7qI0eDwrHnAqo3KvtCBQgYPkPEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBbapKcP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBbapKcP"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9309d4ea213so86221585a.1
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784931364; x=1785536164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8AX/SKNGW3THUHvttxdn31TqYdRVFdDsoO8CoTIM7LE=;
        b=KBbapKcP8cg7c5NIFOhfwwKNDn9PpOR0UEnPwe3ysDm45XkcWf4riJlST+azvAY6Ay
         R+olbZuBCSez73hE30nPw7cIY9JQwPYg44JVGwI0Hfi+VS7jJjNXjeXNZlNHA2J93daO
         Kx/vyAkvGqR/fdHAKeZapuGpzVIk/a6yDmkE7tq3VDMdFdR/LsHZIohPjQAtd36LuDS+
         9pTtJFvotE7T7plh9C7hewMT9gYAImewfMf0hpE4C3FBmylVnN5L/zGtbZ/i124iAJz1
         nexleY9Do7CPa5mXrFOZJsipJrEUPlD023bLow4JRj2ZXccY3mryWznhcGnk9EjQP2HL
         ELeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784931364; x=1785536164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8AX/SKNGW3THUHvttxdn31TqYdRVFdDsoO8CoTIM7LE=;
        b=SIpyr4M0qo+mh3iGm4BWiOpLmF3QklZ/knfojNDSLObRMZjHEV4d5Zz2TMxDVNih6v
         6SlTxMmciM9bgABSTCBhFK9W6zLMey5+vltSsKbM8SvnXaGSX66J8J8CNlZqfSFtejpK
         I7VPgO5Th/Xf3COD7sAFRUvx5ZFFnCfH69HyTg/kUyOyDDS6mxJrQaFR0YmmveawL1IG
         Gtm9P9MQbDwEd6pxs0XxRgGD+18nfbho4bLgUwynPsyWgz9LAaP5MiXiuVpcVNCY5BZN
         j9SkH7+5uZ3/xesU9BLJPUkG2LF+n7gdK5H6Sle1iMX9HTQIRAZ57YHERZjsL7G4eokz
         m9eQ==
X-Gm-Message-State: AOJu0YxgT8eoH+5ehphH1PTk9ivyCG3B42zNhnzp4f1X95j/wjqFIg3+
	6GAMqzvGPk5ZxgWUTDesf1hHlgV+oTh0Zugw4Z4PJnOgEf00nrmxL+0Kj0RGtQEMwtVjTjPv
X-Gm-Gg: AR+sD12EefrAFMlwoqA6LD8gT+d4MqkTOX5U/vlJ77e+y5xz1a+tscM8puua1PORZA6
	OOmD/+gVwYepp6IAs8RzdQ5xFXsHzKq8vA2Qdw7LIJJKERy5HbWs2SIegxHLQq4MoBr7XorGV7h
	SLy19sLDFmocCNzPM9CV1+j9AHAi0In08NN8ExqGwEFww220bscrQJIajkNbmUx+o8DyO8UU+tz
	gqmsY0WXbJ1KQpD49tqgYdmz1FtqHQ+gvf/8Qb7lD6kGadNkXkVOWoyo6szz5VLS9N1YVXz3i+I
	/i1b8/jKWFha/kHqEYrTHOmevY4koq26sPuO6H6mq6guRoJ2/kFB0K3gNrrN971NjVzoZCFAqgH
	Tg9FLdEGP/6adNlC7nV5/DKxVA5a1llBOjFixpHr4SaHaHGT4Vj9N0kh/Jsy8J9Jz9csk2f43
X-Received: by 2002:a05:620a:d88:b0:8cf:c513:349c with SMTP id af79cd13be357-9310390819bmr1034683885a.9.1784931364234;
        Fri, 24 Jul 2026 15:16:04 -0700 (PDT)
Received: from beelink.. ([187.15.144.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de53febasm18428785a.14.2026.07.24.15.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:16:03 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-input@vger.kernel.org
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	aczubak@google.com,
	jdenose@google.com,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [BUG] HID: haptic: use-after-free of devm haptic data in hid_haptic_destroy() when an evdev fd outlives the HID device
Date: Fri, 24 Jul 2026 19:15:52 -0300
Message-ID: <20260724221552.187773-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While looking at hid-multitouch after a Sashiko AI review pointed at the
teardown path, I found a use-after-free in hid_haptic_destroy(), and I can
reproduce it with KASAN on an unmodified mainline tree (v7.2-rc4,
48a5a7ab8d6a).

I am reporting rather than sending a fix because the naive fix does not
work (see below) and the right one is a lifetime decision I'd rather leave
to you; I'm happy to implement whatever direction you prefer.

Root cause
==========

td->haptic is allocated with devm on the HID device:

  drivers/hid/hid-multitouch.c:2111
    td->haptic = devm_kzalloc(&hdev->dev, sizeof(*(td->haptic)), GFP_KERNEL);

and it becomes the force-feedback private data / destroy callback:

  drivers/hid/hid-haptic.c
    ff->private = haptic;
    ff->destroy = hid_haptic_destroy;

hid_haptic_destroy() dereferences it from the very first line:

    static void hid_haptic_destroy(struct ff_device *ff)
    {
        struct hid_haptic_device *haptic = ff->private;
        struct hid_device *hdev = haptic->hdev;   /* <-- deref */

When the HID device is removed (unplug, or UHID_DESTROY), devres frees the
devm allocations, including td->haptic. But the input device -- and thus
its force-feedback device -- can outlive the HID device: if a process holds
an evdev fd open across the removal, input_dev_release() (and with it
input_ff_destroy() -> ff->destroy() -> hid_haptic_destroy()) runs only when
that last fd is closed, which is after devres already freed td->haptic.

So hid_haptic_destroy() runs on a freed haptic object.

hid_haptic_init() does take a get_device(&hdev->dev) (released by the
matching put_device() in hid_haptic_destroy()), but that only pins the
struct hid_device memory; it does not keep the devres-managed allocations
alive, since those are released at driver unbind, not at the final device
kref put. So the existing get_device()/put_device() is not sufficient to
protect td->haptic here.

KASAN
=====

Unmodified v7.2-rc4 (48a5a7ab8d6a), CONFIG_KASAN, CONFIG_HID_MULTITOUCH,
CONFIG_HID_HAPTIC, CONFIG_UHID:

BUG: KASAN: slab-use-after-free in hid_haptic_destroy+0x3c9/0x410
Read of size 8 by task haptic_uaf
Call Trace:
 hid_haptic_destroy+0x3c9/0x410
 input_ff_destroy+0x86/0x140
 input_dev_release+0x18/0xd0
 device_release+0xc8/0x240
 kobject_put+0x14d/0x280
 evdev_free+0x46/0x60
 ...
 __fput+0x711/0xaa0
 __x64_sys_close+0x78/0xd0
Allocated by task:
 devm_kmalloc+0x6f/0x220
 mt_probe+0xf8/0xb80
 hid_device_probe+0x4a9/0x7e0
Freed by task:
 kfree
 release_nodes+0xb9/0x110
 devres_release_group+0x234/0x390
 hid_device_remove+0xf0/0x220
 device_release_driver_internal+0x394/0x560

The allocated-by (devm_kmalloc / mt_probe) and freed-by (devres release on
hid_device_remove) confirm td->haptic; the read-by is hid_haptic_destroy()
from the evdev close() path.

What does not fix it
====================

The obvious-looking change -- moving destroy_workqueue() to the top of
hid_haptic_destroy() so the queued work is drained before the report
buffers are freed -- does NOT fix this. I built that and re-ran the same
reproducer: the splat still fires (offset shifts by a few bytes). It cannot
help, because the object being read is haptic itself, already freed before
the function runs; reordering statements inside a function that operates on
freed memory does not change that.

Reproducer
==========

A uhid program that emulates a Win8 haptic touchpad, opens the resulting
evdev, uploads an FF_HAPTIC effect, and then closes the HID device
(UHID_DESTROY) while still holding the evdev fd, closing it last. Build:
cc -O2 -static -o haptic_uaf haptic_uaf.c ; run on a KASAN kernel.

// Repro: emulate a Win8 haptic touchpad via uhid, answer GET_REPORT,
// upload and fire an FF effect, then destroy the HID device while the
// evdev fd is still held -> hid_haptic_destroy() on freed haptic -> KASAN.
#define _GNU_SOURCE
#include <linux/uhid.h>
#include <linux/input.h>
#include <linux/uinput.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <poll.h>
#include <errno.h>
#include <dirent.h>
#include <sys/ioctl.h>
#ifndef FF_HAPTIC
#define FF_HAPTIC 0x4f
#endif

// HID report descriptor: Win8 precision touchpad + haptics usage page (0x0E)
static unsigned char rdesc[] = {
0x05,0x0d,              // Usage Page (Digitizer)
0x09,0x05,              // Usage (Touch Pad)
0xa1,0x01,              // Collection (Application)
0x85,0x01,              //  Report ID (1)
0x09,0x22,              //  Usage (Finger)
0xa1,0x02,              //  Collection (Logical)
0x09,0x47,              //   Usage (Confidence)
0x09,0x42,              //   Usage (Tip Switch)
0x15,0x00,0x25,0x01,    //   Logical Min 0 Max 1
0x75,0x01,0x95,0x02,    //   Report Size 1 Count 2
0x81,0x02,              //   Input (Data,Var,Abs)
0x95,0x06,0x81,0x03,    //   Count 6 Input (Const) pad
0x75,0x08,0x09,0x51,    //   Report Size 8 ; Usage (Contact Id)
0x95,0x01,0x15,0x00,0x25,0x3f, //  Count1 Min0 Max63
0x81,0x02,              //   Input
0x05,0x01,              //   Usage Page (Generic Desktop)
0x15,0x00,0x26,0xff,0x0f, //  Min0 Max4095
0x75,0x10,0x55,0x0e,0x65,0x11, // Size16, unit exponent, cm
0x09,0x30,0x35,0x00,0x46,0x00,0x00, // Usage X
0x95,0x01,0x81,0x02,
0x09,0x31,0x81,0x02,    //   Usage Y
0x05,0x0d,              //   Usage Page (Digitizer)
0x09,0x30,              //   Usage (Tip Pressure)
0x15,0x00,0x26,0xff,0x00, // Min0 Max255
0x55,0x00,               //   Unit Exponent 0
0x66,0x01,0x01,          //   Unit = gram (HID_UNIT_GRAM 0x0101)
0x35,0x00,0x46,0xff,0x00,//   Phys Min0 Max255 (for resolution)
0x75,0x08,0x95,0x01,0x81,0x02, // Size8 Count1 Input
0x65,0x00,               //   Unit reset 0
0xc0,                   //  End Collection
// Contact count
0x05,0x0d,0x09,0x54,0x15,0x00,0x25,0x3f,0x75,0x08,0x95,0x01,0x81,0x02,
// Contact count maximum (feature)
0x85,0x02,0x09,0x55,0x25,0x3f,0xb1,0x02,
// Win8 cert blob 0xff0000c5 report_count=256 size=8 (feature)
0x85,0x03,0x06,0x00,0xff,0x15,0x00,0x26,0xff,0x00,
0x75,0x08,0x96,0x00,0x01,0x09,0xc5,0xb1,0x02,  // size/count BEFORE usage 0xc5
0xc0,                   // End Collection (touch pad)
// ---- Haptics collection (usage page 0x0E) ----
0x05,0x0e,              // Usage Page (Haptics)
0x09,0x01,              // Usage (Simple Haptic Controller)
0xa1,0x01,              // Collection (Application)
// Feature: Waveform list + Duration list + Auto trigger (auto_trigger_report)
0x85,0x05,
0x09,0x10,              //  Usage (Waveform List)
0xa1,0x02,              //  Collection (Logical)
0x05,0x0a,              //   Usage Page (Ordinal)
0x09,0x03,0x09,0x04,    //   Ordinal 3, Ordinal 4 (press/release waveforms)
0x15,0x03,0x25,0x04,0x75,0x08,0x95,0x02,0xb1,0x02,
0xc0,
0x05,0x0e,0x09,0x11,    //  Usage Page Haptics ; Duration List
0xa1,0x02,0x05,0x0a,0x09,0x03,0x09,0x04,
0x15,0x03,0x25,0x04,0x75,0x08,0x95,0x02,0xb1,0x02,0xc0,
0x05,0x0e,              //  Usage Page (Haptics)
0x09,0x20,              //  Usage (Auto Trigger) -> auto_trigger_report (FEATURE)
0x15,0x00,0x26,0xff,0x00,0x75,0x08,0x95,0x01,0xb1,0x02,
// Manual trigger must be in an OUTPUT report (input_mapping only sees input/output)
0x85,0x06,              //  Report ID 6
0x09,0x21,              //  Usage (Manual Trigger) -> manual_trigger_report (OUTPUT)
0x15,0x00,0x26,0xff,0x00,0x75,0x08,0x95,0x01,0x91,0x02,
0x09,0x23,0x09,0x24,0x09,0x25, // Intensity, RepeatCount, RetriggerPeriod
0x75,0x08,0x95,0x03,0x91,0x02, // OUTPUT
0xc0,                   // End Collection (haptics)
};

static int uhid_write(int fd, const struct uhid_event *ev){
    ssize_t n = write(fd, ev, sizeof(*ev));
    return n<0? -1:0;
}
static int create(int fd){
    struct uhid_event ev; memset(&ev,0,sizeof(ev));
    ev.type=UHID_CREATE2;
    strcpy((char*)ev.u.create2.name,"hid-haptic-repro");
    memcpy(ev.u.create2.rd_data,rdesc,sizeof(rdesc));
    ev.u.create2.rd_size=sizeof(rdesc);
    ev.u.create2.bus=BUS_USB; ev.u.create2.vendor=0x1234; ev.u.create2.product=0x5678;
    return uhid_write(fd,&ev);
}
// answer any GET_REPORT with zeros so hid_hw_wait() does not stall
static void answer_get(int fd, struct uhid_event *ev){
    struct uhid_event a; memset(&a,0,sizeof(a));
    a.type=UHID_GET_REPORT_REPLY;
    a.u.get_report_reply.id=ev->u.get_report.id;
    a.u.get_report_reply.err=0;
    a.u.get_report_reply.size=64;
    uhid_write(fd,&a);
}
int main(){
    setvbuf(stdout,NULL,_IONBF,0);
    int fd=open("/dev/uhid",O_RDWR|O_CLOEXEC);
    if(fd<0){perror("open uhid");return 1;}
    if(create(fd)){perror("create");return 1;}
    printf("[+] uhid created, pumping events\n");
    // pump events ~3s so hid-multitouch/haptic can probe (answering GET_REPORT)
    struct pollfd p={.fd=fd,.events=POLLIN};
    for(int i=0;i<3000;i++){
        if(poll(&p,1,1)>0){
            struct uhid_event ev; memset(&ev,0,sizeof(ev));
            if(read(fd,&ev,sizeof(ev))>0){
                if(ev.type==UHID_GET_REPORT){ answer_get(fd,&ev); }
            }
        }
    }
    printf("[+] probe window done; opening FF on the touchpad evdev\n");
    // hid-haptic's FF device lives on the touchpad input; find the evdev with EV_FF
    int efd=-1; char chosen[64]={0};
    for(int e=0;e<64;e++){
        char path[64]; snprintf(path,sizeof(path),"/dev/input/event%d",e);
        int t=open(path,O_RDWR); if(t<0) continue;
        unsigned long ff[4]={0};
        if(ioctl(t,EVIOCGBIT(EV_FF,sizeof(ff)),ff)>=0 && (ff[0]|ff[1]|ff[2]|ff[3])){
            printf("[+] FF found at %s (ff bits %lx)\n",path,ff[0]);
            efd=t; strcpy(chosen,path); break;
        }
        close(t);
    }
    if(efd<0){ printf("[!] no FF evdev found\n"); }
    else {
        // upload a haptic effect and fire it many times to keep work queued
        struct ff_effect eff; memset(&eff,0,sizeof(eff));
        eff.type=FF_HAPTIC; eff.id=-1;
        if(ioctl(efd,EVIOCSFF,&eff)>=0){
            printf("[+] effect uploaded id=%d, triggering burst\n",eff.id);
            struct input_event play={0}; play.type=EV_FF; play.code=(unsigned)eff.id; play.value=1;
            for(int k=0;k<200;k++) (void)!write(efd,&play,sizeof(play));
            printf("[+] burst done (work queued)\n");
        } else printf("[!] EVIOCSFF failed errno=%d\n",errno);
    }
    // destroy now; the evdev fd is closed last, after devres freed haptic
    struct uhid_event d; memset(&d,0,sizeof(d)); d.type=UHID_DESTROY;
    uhid_write(fd,&d);
    printf("[+] UHID_DESTROY sent\n");
    if(efd>=0) close(efd);
    close(fd);
    usleep(500000);
    printf("[+] program end\n");
    return 0;
}

Possible directions
===================

The haptic data that ff->destroy() touches has to outlive the HID device's
devres. Two shapes come to mind, but I don't want to guess your preference:

  (a) allocate the haptic struct (and the buffers hid_haptic_destroy frees)
      without devm, and free them in hid_haptic_destroy() itself, which is
      already the FF destroy callback and already balances the hdev
      reference; or

  (b) ensure the input device and its FF are torn down before the devres
      release (i.e. not deferred past unbind by a held evdev fd).

Happy to turn either into a patch once you tell me which you'd prefer.

The area was flagged by Sashiko AI review <sashiko-bot@kernel.org>
while reviewing an unrelated patch of mine; the analysis, reproducer and
KASAN run above are mine.

Thanks,
Aldo
