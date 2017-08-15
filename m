From: Anton Volkov <avolkov@ispras.ru>
Subject: Possible race in ucb1400_ts.ko
Date: Tue, 15 Aug 2017 16:46:25 +0300
Message-ID: <237b7e86-f8da-ae37-b56d-4786bbfaefc4@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: marek.vasut@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

Hello.

While searching for races in the Linux kernel I've come across 
"drivers/input/touchscreen/ucb1400_ts.ko" module. Here is a question 
that I came up with while analyzing results. Lines are given using the 
info from Linux v4.12.

Consider the following case:

Thread 1:                   Thread 2:
ucb1400_suspend
->ucb1400_ts_start
     ucb->stopped = false
     enable_irq()

ucb1400_resume
->ucb1400_ts_stop           ucb1400_irq
     ucb->stopped = true       while(!ucb->stopped && ...)
     (ucb1400_ts.c: line 230)  (ucb1400_ts.c: line 202)
     disable_irq()

The value of ucb->stopped may be changed in the midst of 'while' loop 
iterations or prevent all of them from happening. Is this feasible from 
your point of view? If so, is it a benign race or is it serious?

Thank you for your time.

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov@ispras.ru
