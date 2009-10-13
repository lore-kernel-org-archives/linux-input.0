From: iceberg <strakh@ispras.ru>
Subject: [BUG] ati_remote2.c: possible mutex_lock without mutex_unlock
Date: Tue, 13 Oct 2009 17:52:07 +0000
Message-ID: <1255456327.22233.0@pamir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.ispras.ru ([83.149.198.201]:56492 "EHLO smtp.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759716AbZJMNtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 09:49:55 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Linux Kernlel Mailing List <linux-kernel@vger.kernel.org>, linux-input@

	KERNEL_VERSION: 2.6.31
	DESCRIBE:

	In driver ./drivers/input/input.c possible call to mutex_lock 
from function input_devices_seq_start without mutex_unlock.

	After calling input_devices_seq_start we can't know whether 
mutex was locked or not. 
Case 1. If mutex_lock_interruptible was not 
locked due to interrupt then input_devices_seq_start returns NULL. 
Case 2. If mutex was successfuly locked but seq_list_start returned 
NULL then input_devices_seq_start returns NULL too. 
The last case occurs if seq_list_start is called with pos>size of 
input_dev_list or pos<0.

Hence, after calling input_devices_seq_start we can not simply check 
that result is not NULL and call input_devices_seq_stop function 
which unlocks the mutex. Because in case 2 the mutex will stay locked.
void * ret = input_devices_seq_start(...);
if(ret!=NULL) {
	//mutex is acquired for sure
	input_devices_seq_stop(...);//unlocks the mutex
} else {
	//mutex may be acquired or not
}

 783 static void *input_devices_seq_start(struct seq_file *seq, loff_t 
*pos)
 784{
 785        if (mutex_lock_interruptible(&input_mutex))
 786                return NULL;
 787
 788        return seq_list_start(&input_dev_list, *pos);
 789}

 663struct list_head *seq_list_start(struct list_head *head, loff_t 
pos)
 664{
 665        struct list_head *lh;
 666
 667        list_for_each(lh, head)
 668                if (pos-- == 0)
 669                        return lh;
 670
 671        return NULL;
 672}
 673
 674EXPORT_SYMBOL(seq_list_start);
 675

Found by: Linux Driver Verification project

